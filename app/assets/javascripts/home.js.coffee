#cats = ['swim', 'drink', 'Koret', 'Masters', 'workout', 'run', 'cycle']


$(document).ready (e) ->
  $('#cat-input').focus()

$('#cat-input').keyup ->
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
  populate_suggestion_list(distances.splice(0, 4), mag)

$('#go').click (e) ->
  generate_raw_from_selected_cats()

populate_suggestion_list = (suggestions, mag) ->
  $guesses = $('.guesses')
  $guesses.html ''
  $.each suggestions, (i, sug) ->
    xclass = if i == 0 then "selected" else "unselected"
    if mag
      $guesses.append '<span class="cat mag '+xclass+'"><i>'+mag+'</i><span>'+sug.cat+'</span></span>'
    else
      $guesses.append '<span class="cat '+xclass+'"><span>'+sug.cat+'</span></span>'
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


# Populate suggestions list
# Highlight first suggestion
# Handle keyboard navigation


