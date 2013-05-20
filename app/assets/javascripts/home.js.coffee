#cats = ['swim', 'drink', 'Koret', 'Masters', 'workout', 'run', 'cycle']

# shared variables
selected_sug_index = 0
sug_select_mode = false

$(document).ready (e) ->
  $('#cat-input').focus()

$('#cat-input').keyup (e) ->

  switch e.which 
    when 37 then return 
    when 39 then return 
    when 40 
      enter_sug_select_mode()
      return

  $self = $(this)
  query = $self.val()
  magnitude = query.match /^\s*\d+/
  query = query.replace /^\s*\d+\s*/, '' # remove magnitude
  distances = [] 
  for cat in cats
    distances.push {cat: cat, dist: levenshteinenator(query, cat)}
  distances.sort (a, b) ->
    if a.dist < b.dist
      return -1
    if a.dist > b.dist
      return 1
    return 0
  mag = if magnitude then magnitude[0] else null
  populate_suggestion_list(query, distances.splice(0, 4), mag)

$('#go').click (e) ->
  generate_raw_from_selected_cats()

$(document).keydown (e) ->
  switch e.which 
    when 37 then move_selection 'left' 
    when 39 then move_selection 'right' 
    when 13 then console.log submit_selected_tag() 

populate_suggestion_list = (original, suggestions, mag) ->
  $guesses = $('.guesses')
  $guesses.html ''
  # first, append what you're writing
  selected_sug_index = 0 
  if suggestions[0].cat != original
    suggestions.unshift {cat: original}
  $.each suggestions, (i, sug) ->
    if mag
      $guesses.append '<span class="cat mag unselected"><i>'+mag+'</i><span>'+sug.cat+'</span></span>'
    else
      $guesses.append '<span class="cat unselected"><span>'+sug.cat+'</span></span>'
  $('.guesses .cat').click (e) -> 
    new_cat = $(this).text()
    new_cat = new_cat.replace /^\s*\d+\s*/, '' # remove magnitude
    $('.cat-input input').val ''
    $('.guesses').html ''
    if mag
      $('.picked').append '<span class="cat mag"><i>'+mag+'</i><span>'+new_cat+'</span></span>'
    else
      $('.picked').append '<span class="cat"><span>'+new_cat+'</span></span>'

generate_raw_from_selected_cats = () ->
  raw = ""
  $('.picked .cat').each (i, cat) ->
    raw += "," if i > 0
    raw += $(cat).text()
  console.log raw

enter_sug_select_mode = () ->
  console.log "enter mode"
  # unfocus cat input
  $('#cat-input').blur() 
  # select current sug 
  $sugs = $('.guesses .cat')
  if $sugs[selected_sug_index]
    $sugs.removeClass 'selected'
    $sugs.addClass 'unselected'
    $($sugs[selected_sug_index]).removeClass 'unselected'
    $($sugs[selected_sug_index]).addClass 'selected'

move_selection = (direction) ->
  
  # get index of currently selected cat
  if direction == 'left'
    desired_index = selected_sug_index - 1
  else if direction == 'right'
    desired_index = selected_sug_index + 1
  
  console.log desired_index
  
  # see if the desired cat exists
  $sugs = $('.guesses .cat')
  if $sugs[desired_index]
    console.log $sugs[desired_index]
    selected_sug_index = desired_index
    # move selected class to that cat
    $sugs.removeClass 'selected'
    $sugs.addClass 'unselected'
    $($sugs[desired_index]).removeClass 'unselected'
    $($sugs[desired_index]).addClass 'selected'

submit_selected_tag = () ->
  selected_tag = $('.guesses .cat')[selected_sug_index]
  if selected_tag
    # COPYING ABOVE CODE FOR NOW
    new_cat = $(selected_tag).find('span').text()
    mag = $(selected_tag).find('i').text()
    $('#cat-input').val('').focus()
    $('.guesses').html ''
    if mag
      $('.picked').append '<span class="cat mag"><i>'+mag+'</i><span>'+new_cat+'</span></span>'
    else
      $('.picked').append '<span class="cat"><span>'+new_cat+'</span></span>'


