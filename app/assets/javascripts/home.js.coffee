cats = ['swim', 'drink', 'Koret', 'Masters', 'workout', 'run', 'cycle']

console.log()

$('.cat-input input').keyup ->
  $self = $(this)
  query = $self.val()
  distances = [] 
  for cat in cats
    distances.push {cat: cat, dist: levenshteinenator(query, cat)}
  distances.sort (a, b) ->
    if a.dist < b.dist
      return -1
    if a.dist > b.dist
      return 1
    return 0
  console.log distances
  populate_suggestion_list distances.splice(0, 4)

populate_suggestion_list = (suggestions) ->
  $guesses = $('.guesses')
  $guesses.html ''
  for sug in suggestions
    $guesses.append '<span class="cat"><span>'+sug.cat+'</span></span>'
  $('.guesses .cat').click (e) -> 
    console.log "hello"
    new_cat = $('.cat-input input').val()
    $('.cat-input input').val ''
    $('.guesses').html ''
    $('.picked').append '<span class="cat"><span>'+new_cat+'</span></span>'


# Populate suggestions list
# Highlight first suggestion
# Handle keyboard navigation


