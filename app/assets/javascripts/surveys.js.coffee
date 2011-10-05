class Link
	constructor:(id) ->
		@dom_object = $("##{id}")
		@add_events()
	
	add_events: ->
		@dom_object.click (event) => @clicked event
		
	clicked: (event) ->
		alert "works!"

class Question
	constructor: ->
		@dom_object = $('#question_0_container').clone()
		@dom_object.insertBefore( '#add_question' )

class AnswerLink extends Link
	clicked: ->
		@answer = new Answer


class QuestionLink extends Link
	clicked: ->
		alert "works!"
		@question = new Question
		
class Application
	constructor: ->
			@question_link = new QuestionLink('add_question')
			@answer_links = []
			@question_type_selects = []
			
			for link in $('.add_answer')
				@answer_links << new AnswerLink( link.id )
			
			for select in $('.question_type_select')
				@question_type_selects << new QuestionTypeSelect( select.id )
			
	
	# add_events: ->
	# 	@add_events_to_links
	
	# add_events_to_links: ->
	# 	( link.click (event) => @clicked_survey_link event ) for link in @survey_js_links
	# 
	# clicked_survey_link: ->
	# 	last_question = $('input.question').last
	# 	last_question =? $('#survey_description')
	# 	last_question.after(@question_input)
	# 	last_answer = $('input.answer').last
	# 	last_answer =? $('')
	
$ ->
	app = new Application
	app.init