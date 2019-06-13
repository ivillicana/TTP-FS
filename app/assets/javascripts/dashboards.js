$('.dashboards.show').ready(function(){
  setTimer();
  setListenerOnSellStockForm();
});

const setTimer = () => {
  // set timer to every 15 minutes after running once
  getStockQuotes();
  let timer = window.setInterval(getStockQuotes, 900000);
};

const getStockQuotes = () => {
  let stocks = $('.portfolio-stock-name');
  let stockNames = stocks.map((idx, stock) => stock.innerText).get().join(',');
  let symbols = `?symbols=${stockNames}&types=quote`;
  const IEX_BATCH_URL = 'https://api.iextrading.com/1.0/stock/market/batch';
  $.get(IEX_BATCH_URL + symbols)
  .then(handleIEXQuoteResponse);
};

const handleIEXQuoteResponse = (data) => {
  for (const ticker in data){
    const companyQuote = data[ticker].quote;
    const companyNameValue = $(`#${ticker} .portfolio-stock-name, #${ticker} .portfolio-stock-value`);
    if (companyQuote.latestPrice === companyQuote.open) {
      companyNameValue.addClass('neutral');
    } else if (companyQuote.latestPrice >= companyQuote.open){
      companyNameValue.addClass('overperforming');
    } else {
      companyNameValue.addClass('underperforming');
    }
  }
};

const setListenerOnSellStockForm = () => {
  $('#sell-button').click(event => sellStock(event));
};

const sellStock = (event) => {
  const stockName = $('#ticker_symbol').val()
  const sharesQuantity = $('#shares_quantity').val()
  $.post(`/user/stocks/${stockName}`, 
  {
    ticker_symbol: stockName,
    shares_quantity: sharesQuantity
  })
  .done((data) => location.reload());
};