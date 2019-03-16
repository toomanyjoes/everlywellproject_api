class ExpertSearchController < ApplicationController
  before_action :set_user

  THRESHOLD = 30

  # GET /users/:user_id/expert_search?terms[]=x&terms[]=y&terms[]=z
  def index
    if params[:terms].nil? or params[:terms].empty?
      render json: ApiExceptions::ExpertSearchError::NoSearchTermsError,
             each_serializer: ApiExceptionSerializer,
             status: 404
      return
    end
    data = {data: {attributes: {result: nil, terms: params[:terms]}}}
    graph = build_adjacency_list
    path = experts_search(graph, params[:user_id].to_i, params[:terms].map{|t| t.downcase})
    unless path.nil?
      matching_header = path.pop()
      names = user_ids_to_user_names(path)
      names << "(#{matching_header})"
      data[:data][:attributes][:result] = names.join()
      data[:data][:attributes][:friend_id] = path.pop()
      render json: data
    else
      data[:data][:attributes][:result] = "No search result found for given terms"
      render json: data
    end

  end

  private

  def user_ids_to_user_names(user_ids)
    ids = "#{user_ids.join(',')}"
    sql = "SELECT id, concat(first_name,' ',last_name) as name from users where id IN (#{ids})"
    result = ActiveRecord::Base.connection.execute(sql)
    names = result.map { |record|
      [
          record['id'],
          record['name']
      ]
    }.to_h
    user_ids.map { |id| "#{names[id]} -> "}
  end

  def get_users_headings(user_id)
    headings = Userdatum.where(user_id: user_id).select("data").as_json
    headings.map { |record|
      [
          record['data'].split
      ].flatten
    }
  end

  def build_adjacency_list
    sql = "SELECT user_id, json_agg(friend_id) as friendships from friends group by user_id;"
    result = ActiveRecord::Base.connection.execute(sql)
    return result.map { |record|
      [
        record['user_id'], JSON.parse(record['friendships']),
      ]
    }.to_h
  end

  def experts_search(graph, user_id, terms)
    return nil if graph[user_id].nil?
    q = SimpleQueue.new
    visited = {}
    search = {}
    search[user_id] = false
    graph[user_id].each do |exclude| # friends already adjacent to the user we don't want to search
      search[exclude] = false
    end
    q.append([user_id])
    while q.size > 0
      path = q.dequeue
      unless visited.fetch(path[-1], false)
        friend_id = path[-1]
        if search.fetch(friend_id, true)
          if finished_search(friend_id, terms, path)
            return path
          else
            search[friend_id] = false
          end
        end
        graph.fetch(friend_id, []).each do |adjacent_friend|
          new_path = Array.new(path)
          new_path << adjacent_friend
          q.append(new_path)
        end
      end
      visited[friend_id] = true
    end
  end

  def finished_search(friend_id, terms, path)
    headings = get_users_headings(friend_id)
    headings.each do |h|
      intersect = terms & h
      val = (intersect.length.to_f / h.length.to_f) * 100
      if val >= THRESHOLD
        path.push(h.join(" "))
        return true
      end
    end
    false
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end