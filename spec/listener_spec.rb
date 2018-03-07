require "spec_helper"

RSpec.describe Listener do
  describe "#posts" do
    it "filters out self posts" do
      VCR.use_cassette("frontpage") do
        self_posts = Listener.new.posts.select { |p| p[:is_self] }

        expect(self_posts).to be_empty
      end
    end

    it "filters out non-youtube links" do
      VCR.use_cassette("frontpage") do
        posts = Listener.new.posts.reject { |p| p[:url].include?("youtu") }

        expect(posts).to be_empty
      end
    end

    it "correctly parses posts" do
      VCR.use_cassette("frontpage") do
        post = Listener.new.posts.first

        expect(post[:url]).to be
        expect(post[:title]).to be
        expect(post[:genre]).to be
        expect(post[:flair]).not_to be
      end
    end
  end

  describe "#play_all" do
    it "spawns an mpv process", :proc do
      require "sys/proctable"

      VCR.use_cassette("frontpage") do
        pid = fork do
          Listener.new.play_all
        end

        # Wait for the process to start
        # This is hacky and makes me sad
        sleep(3)
        ps = Sys::ProcTable.ps

        mpv_procs = ps.select { |p| p.cmdline.include? "mpv --no-video" }
        expect(mpv_procs).not_to be_empty

        # Teardown
        `killall mpv` # again, hacky af
        Process.kill("KILL", pid)
        Process.wait
      end
    end
  end
end
