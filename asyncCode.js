import { get } from 'axios';

const urls = [
  'https://api.publicapis.org/entries',
  'https://catfact.ninja/fact',
  'https://api.coindesk.com/v1/bpi/currentprice.json'
];

const maxConcurrentRequests = 2;
const requestQueue = [];

async function fetchData(url) {
  try {
    const response = await get(url);
    console.log(`Fetched data from ${url}:`, response.data);
  } catch (error) {
    console.error(`Error fetching data from ${url}:`, error.message);
  }
}

async function processNextRequest() {
  const url = requestQueue.shift();
  if (url) {
    await fetchData(url);
    await processNextRequest();
  }
}

async function startFetching() {
  requestQueue.push(...urls);

  const concurrentRequests = Array(maxConcurrentRequests)
    .fill(null)
    .map(processNextRequest);

  await Promise.all(concurrentRequests);
  console.log('All requests completed.');
}


// derived method
startFetching();