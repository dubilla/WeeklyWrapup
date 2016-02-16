#!/usr/bin/env ruby

require 'httparty'
require 'nokogiri'
require 'open-uri'
require 'pry'

leagueID = ENV['LEAGUE_ID']
leagueUrl = "http://games.espn.go.com/fba/scoreboard?leagueId=#{leagueID}"

doc = Nokogiri::HTML(open(leagueUrl))
matchupContainerHtml = doc.css('#scoreboardMatchups')
matchupsHtml = matchupContainerHtml.css('.matchup')
matchupsDetails = matchupsHtml.map{|m| { name: m.css('.name').map{|o| o.text }, score: m.css('.score').map{|o| o.text } } }
matchups = []
matchupsDetails.each do |m|
  matchups.push({
    awayOpponent: { name: m[:name].first, score: m[:score].first },
    homeOpponent: { name: m[:name].last, socre: m[:score].last }
  })
end

puts matchups
