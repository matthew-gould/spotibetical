class Playlist < ActiveRecord::Base
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs

  def self.generate_for_week!
    playlist = Playlist.create!

    # Figure out which songs won, and add them
    # Look at songs not vetoed
    by_letter = Song.unvetoed.group_by { |s| s.sort_letter }
    by_letter.each do |letter, songs|
      winner = songs.max_by { |s| s.votes.count }
      playlist.songs.push winner
    end

    playlist
  end
end