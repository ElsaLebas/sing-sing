import algoliasearch from 'algoliasearch/lite';
import instantsearch from 'instantsearch.js';
import { searchBox, hits } from 'instantsearch.js/es/widgets';

const searchClient = algoliasearch('F3K65Y2QCC', '1a8775809faeaf09ef5607fc788842bb');

const search = instantsearch({
  indexName: 'sing-sing',
  searchClient,
});

search.addWidgets([
  searchBox({
    container: "#searchbox"
  }),

  hits({
    container: "#hits"
  })
]);

search.start();
