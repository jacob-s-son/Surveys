class Link
	constructor:(id) ->
		@dom_object = $("a##{id}")
		@add_events
	
	add_events: ->
		@dom_object.click (event) => @clicked
		
	clicked: ->
		true

class Question extends DomElement
	clicked: ->
		question = new Question

class DomElement
	init: ->
		@dom_object = null
	
	create_in_dom: ->


class AnswerLink extends Link
	clicked: ->
		question = new Answer


class QuestionLink extends Link
	clicked: ->
		question = new Question
		question.create_in_dom
		
class Application
	constructor: ->
			@question_link = new QuestionLink('#add_question')
			@answer_links = [] 
			
			for link in $('.add_answer')
				@answer_links << new AnswerLink( link.attr('id') )
	
	add_events: ->
		@add_events_to_links
	
	add_events_to_links: ->
		( link.click (event) => @clicked_survey_link event ) for link in @survey_js_links
	
	clicked_survey_link: ->
		last_question = $('input.question').last
		last_question =? $('#survey_description')
		last_question.after(@question_input)
		last_answer = $('input.answer').last
		last_answer =? $('')
	
$ ->
	app = new Application
	app.init