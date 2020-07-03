module IgCrawler
  class Crawl
    attr_reader :result

    def initialize(url)
      @result = crawl url
    end

    def crawl(url)
      r = Faraday.get "#{url}?__a=1"
      response = JSON.parse r.body, symbolize_names: true
      caption = response.dig(:graphql, :shortcode_media, :edge_media_to_caption, :edges)[0].dig(:node, :text)
      likes = response.dig(:graphql, :shortcode_media, :edge_media_preview_like, :count)
      comments = response.dig(:graphql, :shortcode_media, :edge_media_preview_comment, :count)

      {link: url, likes: likes.to_s, comments: comments.to_s, caption: caption, created_time: DateTime.now.strftime('%s')}.to_json
    rescue => e
      { "reason": "Post is not public" }
    end
  end
end