require 'cgi'
require 'open-uri'

class YoutubeAudio::Url

  def initialize(id)
    @id = id
  end

  def video_url
    #todo - avoid hitting disk
    #HTML5 mechanism changed.  The webm url is now just "blob:xxx......"
    #need to figure out video format of this input stream
    #UPDATE this is apparently called a blob url
    #http://www.html5rocks.com/en/tutorials/workers/basics/#toc-inlineworkers-bloburis
    info = open(info_url).readline
    formats = CGI::parse(info)["adaptive_fmts"][0]
    audio_stream_url = CGI::parse(formats)["url"][3]
  end

  private

  def info_url
    "http://www.youtube.com/get_video_info?video_id=#{@id}"
  end
end
