require 'multi_json'
require 'tomograph/path'
require 'tomograph/api_blueprint/yaml'
require 'tomograph/tomogram/action'

module Tomograph
  class Tomogram
    def initialize(apib_path: nil, drafter_yaml_path: nil, drafter_yaml: nil, prefix: '')
      @documentation = Tomograph::ApiBlueprint::Yaml.new(apib_path, drafter_yaml, drafter_yaml_path)
      @prefix = prefix
    end

    def to_hash
      tomogram.map(&:to_hash)
    end

    def to_json
      MultiJson.dump(to_hash)
    end

    def find_request(method:, path:)
      path = Tomograph::Path.new(path).to_s

      tomogram.find do |action|
        action.method == method && action.path.match(path)
      end
    end

    private

    def tomogram
      return @tomogram if @tomogram

      actions = @documentation.actions.inject([]) do |result, action|
        result.push(action.to_tomogram.add_prefix(@prefix))
      end
      @tomogram = combine_by_responses(actions)
    end

    def combine_by_responses(actions)
      actions.group_by {|action| "#{action.method} #{action.path}"}.map do |_key, related_actions|
        Tomograph::Tomogram::Action.new(
          path: related_actions.first.path.to_s,
          method: related_actions.first.method,
          request: related_actions.first.request,
          responses: related_actions.map(&:responses).flatten
        )
      end.flatten
    end
  end
end
