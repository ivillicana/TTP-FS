module UsersHelper

  def render_user_portfolio_stocks(portfolio)
    if !portfolio[:companies].blank?
      render partial: "dashboards/portfolio-stocks", locals: {portfolio: portfolio}
    else
      render partial: "dashboards/none"
    end
  end

  def render_user_transactions(transactions)
    if !transactions.blank?
      render partial: "dashboards/stock-transactions", locals: {transactions: transactions}
    else
      render partial: "dashboards/none"
    end
  end

end
