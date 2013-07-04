# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

changeRepositoryStatus = (target) ->
  repository_name = $(target).data 'repository-name'
  console.log "#{target.checked ? "on" : "off"} #{repository_name}"

$(document).ready ->
  $('#repositories .repository-status').show
  $('#repositories .repository-status').change ->
    changeRepositoryStatus(this)
