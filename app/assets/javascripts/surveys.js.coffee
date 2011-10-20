class SurveyElement
	constructor: ->

	init: ->
		@nr = $( @dom_class_selector ).size()
		@dom_object = $( "#{@dom_object_selector}" ).first().clone()
		@dom_object.insertBefore( $( "##{@add_link_id}" ).parent() )
	
		@update_dom_attributes()
		@attach_handler_to_remove_link()
		
	update_dom_attributes: () ->
		@label_nr = $( @dom_class_selector ).filter(':not(.hidden)').size()
		
		for obj in @dom_object.find('*')
			@update_label $(obj) if $(obj).is 'label'
			for attrib in ['id', 'for', 'name']
				if eval "obj.#{attrib}"
					$(obj).attr(attrib, eval("obj.#{attrib}").replace(@replace_regex, "$1#{@nr}") )
				else if $(obj).attr(attrib)
					$(obj).attr(attrib, $(obj).attr(attrib).replace(@replace_regex, "$1#{@nr}") )

		@dom_object.attr('id', @dom_object.attr('id').replace(@replace_regex, "$1#{@nr}") )
		
		if @dom_object.hasClass 'hidden'
			@dom_object.removeClass 'hidden'
			@dom_object.find("input[type='hidden']").val(false)
	
	attach_handler_to_remove_link: ->
		@remove_link_id = @dom_object.find(@remove_link_selector).attr('id')

class Question extends SurveyElement
	constructor: ->
		@dom_object_selector = '#question_0_container'
		@dom_class_selector = 'div.question_container'
		@replace_regex = /(questions_attributes_|question_|\[questions_attributes\]\[)[0]/
		@label_regex = /Question #[0-1]|Answer #[0-1]\.[0-9]/
		@add_link_id = 'add_question'
		@remove_link_selector = 'a.question_remove_link'
	
	init: ->
		super()
		@attach_select_handler()
		@attach_event_to_answer_link()
		@delete_answers()
		
	attach_select_handler: ->
		select_id = @dom_object.find('select').attr('id')
		application.question_type_selects.push new QuestionTypeSelect( select_id )
		
	attach_event_to_answer_link: ->
		add_answer_id = @dom_object.find('.add_answer').attr('id')
		application.answer_links.push new AnswerLink( add_answer_id )
	
	attach_handler_to_remove_link: ->
		super()
		application.question_remove_links.push new QuestionRemoveLink( @remove_link_id )
		
	delete_answers: ->
		@dom_object.find('select').val('text')
		answers_container = @dom_object.find('.answers_container')
		answers_container.addClass('hidden')
		answers_container.find('.answer_container:gt(0)').remove()
	
	update_label: (label)->
		obj_text = label.text()
		if obj_text && obj_text.match(@label_regex)
			str = obj_text.replace /#([0-1])(\.[0-9])?/, ($1, $2, $3) =>
				result = "##{@label_nr}"
				unless typeof($3) == 'undefined' then result + $3 else result
			label.text(str)
			
		
class Answer extends SurveyElement
	constructor: (@add_link_id, @parent_id)->
		@dom_object_selector = "##{parent_id} :first-child"
		@dom_class_selector = "div##{@parent_id} .answer_container"
		@replace_regex = /(answers_attributes_|answer_|\[answers_attributes\]\[)0/
		@label_regex = /Answer #[0-9]+\.[0-9]+/
		@remove_link_selector = 'a.answer_remove_link'
		
	attach_handler_to_remove_link: ->
		super()
		application.answer_remove_links.push new AnswerRemoveLink( @remove_link_id )
	
	update_label: (label)->
		obj_text = label.text()
		if obj_text && obj_text.match(@label_regex)
			label.text obj_text.replace /#([0-9]+)\.([0-1]+)/, ($1, $2, $3, $4) => 
				# console.log("#{$1}, #{$2}, #{$3}, #{$4}, #{@label_nr}")
				"##{$2}.#{@label_nr}"
	
		
class QuestionTypeSelect
	constructor: (select_id)->
		@dom_object = $("##{select_id}")
		@dom_object.bind 'change', (data, event) => @changed data, event
		
	changed: (data, event)->
		answer_container = @dom_object.parentsUntil('#questions').find('.answers_container')
		if @dom_object.val() == 'option' then answer_container.removeClass('hidden') else answer_container.addClass('hidden')

class Link
	constructor:(@id) ->
		@dom_object = $("##{@id}")
		@add_events()

	add_events: ->
		@dom_object.click (event) => @clicked event

	clicked: (event) ->
		alert "works!"

class AnswerLink extends Link
	clicked: (event)->
		@answer = new Answer( @dom_object.attr('id'), @dom_object.closest("div.answers_container").attr('id') )
		@answer.init()


class QuestionLink extends Link
	clicked: (event)->
		@question = new Question
		@question.init()
		
class RemoveLink extends Link
	clicked: (event)->
		container = @dom_object.closest(@parent_container_selector).first()
		container.addClass 'hidden' unless container.hasClass('hidden') #hiding question
		container.find("input[type='hidden']").val(true) #setting destroy to true
		
		
class QuestionRemoveLink extends RemoveLink
	clicked: (event)->
		@parent_container_selector = 'div.question_container'
		super()
		application.update_question_labels()
		
class AnswerRemoveLink extends RemoveLink
	clicked: (event)->
		@parent_container_selector = 'div.answer_container'
		super()
		application.update_answer_labels(@id)

class FinderForm
	constructor: (@dom_object)->
		@dom_object.submit (event) => @submited event
		
	submited: (event)->
		# @toggleLoading = () => { $("#loading").toggle() };
		
		$.get @dom_object.attr('action'), @dom_object.serialize(), (data)=>
			@dom_object.parent().next().html data

		false
		
class PaginationLink extends Link
	constructor: (link)->
		@dom_object = $(link)
		@add_events()
		
	clicked: (event) ->
		console.log "clicked !"
		$.get @dom_object.attr('href'), (data)=>
			@dom_object.parent().parent().html data
		false
		
		
class Application
	constructor: ->
		@question_link = new QuestionLink('add_question')
		@answer_links = []
		@question_type_selects = []
		@question_remove_links = []
		@answer_remove_links = []
		@finder_forms = []
		
		for link in $('.add_answer')
			@answer_links.push new AnswerLink( link.id )
		
		for select in $('.question_type_select')
			@question_type_selects.push new QuestionTypeSelect( select.id )
			
		for link in $('div.question_remove_link_container > a')
			@question_remove_links.push new QuestionRemoveLink( link.id )
		
		for link in $('div.answer_remove_link_container > a')
			@answer_remove_links.push new AnswerRemoveLink( link.id )
		
		for finder_form in $('form.user_answer')
			@finder_forms.push new FinderForm( $(finder_form) )
		
			
	update_labels: (label_selector)->
		i = 1;
		for label in $(label_selector).filter(':not(:hidden)')
			label = $(label)
			label.text label.text().replace /#([0-9]+)\.([0-9]+)/, ($1,$2) =>
				"##{$2}.#{i}"
			i++;
			
	update_question_labels: ->
			# @update_labels('.question_label')
			i = 1;
			for label in $('.question_label').filter(':not(:hidden)')
				label = $(label)
				str = label.text().replace /#([0-9]+)/, "##{i}" 
				label.text str
				
				for a_label in label.closest('.question_container').find('.answer_label').filter(':not(:hidden)')
					a_label = $(a_label)
					a_label_text = a_label.text().replace /#([0-9]+)\.([0-9]+)/, ($1, $2, $3, $4) =>
						# console.log "#{$1}, #{$2}, #{$3}, #{$4}, #{i}"
						result = "##{i}"
						unless typeof($3) == 'undefined' then result + ".#{$3}" else result
					a_label.text a_label_text
					
				i++;
	
	update_answer_labels: (remove_link_id)->
		parent = $("##{remove_link_id}").closest('.answers_container')
		@update_labels("##{parent.attr('id')} .answer_label")
	
	update_pagination_links: (question_id)->
		for link in $("#result_finder_container_#{question_id} a")
			new PaginationLink link
	
	
$ ->
	app = new Application
	window.application = app