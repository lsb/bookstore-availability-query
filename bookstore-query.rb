require './ask-a-human'
require 'peach'

BookName = "'Cooking For Geeks' by Jeff Potter"

Answers = ["No answer / bad phone number", "Phone answered, does not sell books", "#{BookName} is IN STOCK RIGHT NOW.", "#{BookName} is NOT IN STOCK RIGHT NOW."]

QuestionPhrasing = lambda {|n| "Please call \u2706\u2706\u2706#{n} and ask if #{BookName} is on the shelves for sale right now." }

GS023 = File.read("twilio-numbers.txt").split("\n")

GoldStandards = GS023.zip([0,2,3]).map {|tel, answer_id| [QuestionPhrasing[tel], Answers[answer_id]] + Answers }

FoursquareDump = STDIN.read

PhoneNumbers = FoursquareDump.split("\n").map {|line| line.split("\t") }

Query = lambda {|tel| ask_human_choose_one("Call bookstores in California in the USA", QuestionPhrasing[tel], Answers, GoldStandards, {samples: 1, gs_failure_rate: 0, nonce: "2012 02 03 afternoon"})}

puts PhoneNumbers.pmap {|fsqid, tel, name, zip, lat, lng| ["% 40s".%(name), tel, lat, lng, Query[tel]].join("\t") }.join("\n")
