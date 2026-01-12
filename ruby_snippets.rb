#!/usr/bin/env ruby
# /home/ricky/ruby_test.rb
## API Interaction and Data Normalization
require 'net/http'
require 'uri'
require 'json'

ENDPOINT = 'https://jsonplaceholder.typicode.com/posts' # mock endpoint that echoes form data

def post_form(endpoint, form_data)
    uir
    uri = URI(endpoint)
    req = Net::HTTP::Post.new(uri)
    req['Content-Type'] = 'application/x-www-form-urlencoded'
    req.body = URI.encode_www_form(form_data)
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        resp = http.request(req)
        JSON.parse(resp.body)
    end
end
def normalize_data(obj)
    case obj 
    when Hash
        obj.each_with_object({}) do |(k, v), h|
            h[k.to_sym] = normalize_data(v)
        end
    when Array
        obj.map { |e| normalize_data(e) }
    else
        obj
    end
end
def request_data(endpoint)
    uri = URI(endpoint)
    res =  Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess)
        data = JSON.parse(res.body)
        return normalize_data(data)
    end
    raise "Failed to get data"
    raise "Request failed with status #{res.code}: #{res.body}"
end
def get_users
    request_data("http://jsonplaceholder.typicode.com/users")
end

def get_posts
    request_data("http://jsonplaceholder.typicode.com/posts")
end

def get_comments
    request_data("http://jsonplaceholder.typicode.com/comments")
end


def get_user(user_id)
    posts = request_data("http://jsonplaceholder.typicode.com/posts")
    posts.select { | post | post[:id] = user_id}
end

def get_posts_by_user(user_id)
    all_posts = get_posts
    all_posts.select { |post| post[:userId] == user_id }
end

def get_comments_by_post(post_id)
    get_comments.select { |comment| comment[:postId] == post_id}
end
## Binary Search Tree Implementation
class Node
    attr_accessor :value, :left, :right
    def initialize(value)
        @value = value
        @left = nil
        @right = nil
    end
end
def insert(root, value)
    if root.nil?
        return { value: value, left:nil, right:nil }
    end
    if value < root[:value]
        root[:left] = insert(root[:left], value)
    else
        root[:right] = insert(root[:right], value)
    end
    return root
end
## Recursion Example: Fibo
def sum(limit)
    return limit if limit == 0
    limit + sum(limit - 1)
end
def fibonacci(n)
    return n if n <= 1
    p "#{n}"
    fibonacci(n - 1) + fibonacci(n - 2)
end
begin
    root = nil
    root = insert(root, 22)
    root = insert(root, 15)
    root = insert(root, 12)
    root = insert(root, 30)
    root = insert(root, 8)
    root = insert(root, 20)
    root = insert(root, 30)
    user_posts =  get_posts_by_user(1).first
    sum_result = sum(5)
    puts "Fibonacci #{fibonacci(6)}"
    # puts "Sum of numbers from 0 to 5 is #{sum_result}"
    # puts get_comments_by_post(user_posts[:id])

    # p get_user(1) 
    # p root

    # puts get_users[0]
    # puts get_comments[0]
    # puts get_posts[0]
rescue StandardError => e
    warn "Request failed: #{e.class}: #{e.message}"
end