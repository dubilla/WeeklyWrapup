#!/usr/bin/env ruby

require 'httparty'
require 'nokogiri'
require 'open-uri'

leagueID = ENV['LEAGUE_ID']
leagueUrl = "http://games.espn.go.com/fba/scoreboard?leagueId=#{leagueID}"

doc = Nokogiri::HTML(open(leagueUrl))
matchupContainer = doc.css('#scoreboardMatchups')
matchups = matchupContainer.css('.matchup')
matchupsDetails = matchups.map{|m| { name: m.css('.name').map{|o| o.text }, score: m.css('.score').map{|o| o.text } } }

puts matchupsDetails
