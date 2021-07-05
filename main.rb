require 'algolia'
require 'json'

# init the client
client = Algolia::Search::Client.create(
  'F3K65Y2QCC', # replace with your application ID
  '2ce180c7cf367e03045383cb85c0a338' # replace with your Admin API Key
)

# init the index
index = client.init_index('sing-sing')

file = File.read('songs-dataset.json')
records = JSON.parse(file)

# delete search irrelevant attributes from the dataset
# records.each do |record|
#   record.delete('xx')
#   record.delete('xx')
# end

# prepare data batches
# records.each_slice(1000) do |chunk|
#   index.save_objects(chunk)
# end

# send data
index.save_objects(records)

# configure relevance
index.set_settings(
  {
    searchableAttributes: ['artist', 'unordered(title)', 'unordered(album)'],
    customRanking: ['desc(popularity_score)'],
    attributesForFaceting: ['searchable(genre)']
  }
)


# # Test search
# # ===========

# queries = ["obama", "blockchain", "save ocean", "al gore", "nasa space mars"]

# queries.each do |query|
#   results = index.search(query)
#   p "query : #{query} => nb results :#{results[:nbHits]}"
#     results[:hits].each do |hit|
#       p "title : #{hit[:title]} // speaker : #{hit[:speakers]}"
#     end
# end

# puts '================================'

# results = index.search_for_facet_values('languages', 'french')
# p results

# puts "==========================================="
# facet_values = index.search_for_facet_values('languages', 'french', {
#   maxFacetHits: 1
# })

# p facet_values
# results = index.search('obama')
# p results

# puts '==============================='

# results = index.search('obama', {
#   maxValuesPerFacet: 1
# })

# p results
