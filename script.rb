#!/usr/bin/env ruby
require 'httparty'
require 'nokogiri'
require 'open-uri'

leagueID = ENV['LEAGUE_ID']
leagueUrl = "http://games.espn.go.com/fba/scoreboard?leagueId=#{leagueID}"

doc = Nokogiri::HTML(open(leagueUrl))
puts leagueUrl
matchupContainer = doc.css('#scoreboardMatchups')
matchups = matchupContainer.css('.matchup')
opponents = matchups.map{|m| m.css('.name').map{|o| o.text } }

puts opponents
