module Pronto
  module Formatter
    class GithubPullRequestReviewFormatter < PullRequestFormatter
      def self.name
        'github_pr_review'
      end

      def client_module
        Github
      end

      def pretty_name
        'GitHub'
      end

      def submit_comments(client, comments)
        client.publish_pull_request_comments(comments)
      rescue Octokit::UnprocessableEntity, HTTParty::Error => e
        $stderr.puts "Failed to post: #{e.message}"
      end

      def line_number(message, _)
        message.line&.new_lineno
      end
    end
  end
end

Pronto::Formatter.register(Pronto::Formatter::GithubPullRequestReviewFormatter)
