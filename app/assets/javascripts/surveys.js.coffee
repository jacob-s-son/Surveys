class SurveyElement
	constructor: ->

	init: ->
		@nr = $( @dom_class_selector ).size()	
		@dom_object = $( "#{@dom_object_selector}" ).first().clone()
		@dom_object.insertBefore( $( "##{@add_link_id}" ).parent() )
		@update_dom_attributes()
		
	update_dom_attributes: () ->
		for obj in @dom_object.find('*')
			obj_text = $(obj).text()
			if obj_text && obj_text.match(@label_regex) && $(obj).is("label")
				alert "#{obj_text}"
				$(obj).text( obj_text.replace(/[0-1]/, "#{@nr+1}") )
				
			for attrib in ['id', 'for', 'name']
				if eval "obj.#{attrib}"
					$(obj).attr(attrib, eval("obj.#{attrib}").replace(@replace_regex, "$1#{@nr}") )
				else if $(obj).attr(attrib)
					$(obj).attr(attrib, $(obj).attr(attrib).replace(@replace_regex, "$1#{@nr}") )

		@dom_object.attr('id', @dom_object.attr('id').replace(@replace_regex, "$1#{@nr}") )

class Question extends SurveyElement
	constructor: ->
		@dom_object_selector = '#question_0_container'
		@dom_class_selector = 'div.question_container'
		@replace_regex = /(questions_attributes_|question_|\[questions_attributes\]\[)[0]/
		@label_regex = /Question #[0-1]/
		@add_link_id = 'add_question'
	
	init: ->
		super()
		@attach_select_handler()
		@attach_event_to_answer_link()
		
	attach_select_handler: ->
		select_id = @dom_object.find('select').attr('id')
		application.question_type_selects << new QuestionTypeSelect( select_id )
		
	attach_event_to_answer_link: ->
		add_answer_id = @dom_object.find('.add_answer').attr('id')
		application.answer_links << new AnswerLink( add_answer_id )
		
class Answer extends SurveyElement
	constructor: (@add_link_id, @parent_id)->
		@dom_object_selector = "##{parent_id} :first-child"
		@dom_class_selector = "div##{@parent_id} .answer_container"
		@replace_regex = /(answers_attributes_|answer_|\[answers_attributes\]\[)0/
		@label_regex = /Answer #[0-1]/
		console.log("#{@add_link_id}, #{@parent_id}")
		
class QuestionTypeSelect
	constructor: (select_id)->
		@dom_object = $("##{select_id}")
		@dom_object.bind 'change', (data, event) => @changed data, event
		
	changed: (data, event)->
		answer_container = @dom_object.parentsUntil('#questions').find('.answers_container')
		if @dom_object.val() == 'option' then answer_container.removeClass('hidden') else answer_container.addClass('hidden')

class Link
	constructor:(id) ->
		@dom_object = $("##{id}")
		@add_events()

	add_events: ->
		@dom_object.click (event) => @clicked event

	clicked: (event) ->
		alert "works!"

class AnswerLink extends Link
	clicked: ->
		@answer = new Answer( @dom_object.attr('id'), @dom_object.closest("div.answers_container").attr('id') )
		@answer.init()


class QuestionLink extends Link
	clicked: ->
		@question = new Question
		@question.init()
		
		
class Application
	constructor: ->
			@question_link = new QuestionLink('add_question')
			@answer_links = []
			@question_type_selects = []
			
			for link in $('.add_answer')
				@answer_links << new AnswerLink( link.id )
			
			for select in $('.question_type_select')
				@question_type_selects << new QuestionTypeSelect( select.id )
	
$ ->
	app = new Application
	window.application = app