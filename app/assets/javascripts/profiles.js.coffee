# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ($) ->
  onSwitchChange = (ev, data) ->
    repo_switch = data.el.closest('.switch')
    $(repo_switch).closest('form').find('.icon-spinner').removeClass('hidden')
    $(repo_switch).off "switch-change", onSwitchChange
    $(repo_switch).bootstrapSwitch('setActive', false)
    $(repo_switch).closest('form').submit()

  configureForm = (repo_switch) ->
    closest_form = $(repo_switch).closest('form')
    if ($(repo_switch).bootstrapSwitch('status'))
      closest_form[0].method = 'delete'
      closest_form.find('a.ci-link').removeClass('hidden')
    else
      closest_form[0].method = 'post'
      closest_form.find('a.ci-link').addClass('hidden')

  switchChanged = (repo_switch) ->
    configureForm(repo_switch)
    $(repo_switch).on "switch-change", onSwitchChange
    $(repo_switch).bootstrapSwitch('setActive', true)
    setTimeout(->
      $(repo_switch).closest('form').find('.icon-spinner').addClass('hidden')
    , 50)

  $('#repositories .switch').on "switch-change", onSwitchChange

  $('#repositories .repository-form').on "ajax:success", (ev, data, status, xhr) ->
    repo_switch = $(this).find('.switch')
    setTimeout(->
      switchChanged(repo_switch)
    , 500)

  $('#repositories .repository-form').on "ajax:error", (ev, xhr, status, error) ->
    repo_switch = $(this).find('.switch')
    console.log("ajax:error #{error}")
    setTimeout(->
      $(repo_switch).bootstrapSwitch('toggleState')
      switchChanged(repo_switch)
    , 500)

  $('#repositories .switch').each ->
    configureForm(this)
    $(this).removeClass('hidden')
