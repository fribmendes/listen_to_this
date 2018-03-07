class Listener
  SUBREDDIT = "listentothis".freeze
  URL_REGEX = %r{http(s)?:\/\/(www\.)?youtu(\.)?be}
  TITLE_REGEX = /([\w\s]+ [\s-]+ [\w\s]+\w)/
  GENRE_REGEX = /-+\s+.+\[(.+)\]\s+\(/

  def play_all
    puts "loading..."

    posts.each do |p|
      puts "now playing: #{p[:title]}"

      pid = Process.spawn("mpv --no-video #{p[:url]}", out: "/dev/null", err: "/dev/null")

      Process.wait(pid)
    end
  end

  def posts
    @posts ||=
      session.
        subreddit(SUBREDDIT).
        hot.
        reject(&:is_self).
        select { |p| p.url =~ URL_REGEX }.
        map { |p| take_keys(p) }
  end

  private

  def session
    @session ||= Redd.it(
      user_agent: "Redd:ListenToThis (/u/fribmendes)",
      client_id: ENV["REDDIT_CLIENT_ID"],
      secret: ENV["REDDIT_CLIENT_SECRET"],
    )
  end

  def take_keys(post)
    {
      url: post.url,
      title: parse_title(post.title),
      genre: parse_genre(post.title),
      flair: post.link_flair_text,
    }
  end

  def parse_title(title)
    parse_str(TITLE_REGEX, title)
  end

  def parse_genre(title)
    parse_str(GENRE_REGEX, title)
  end

  def parse_str(regex, str)
    matches = regex.match(str)
    return if matches.nil?

    matches[1]
  end
end
