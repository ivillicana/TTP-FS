module UsersHelper

  def render_user_portfolio_stocks(portfolio)
    if !portfolio[:companies].blank?
      render partial: "dashboards/portfolio-stocks", locals: {portfolio: portfolio}
    else
      render partial: "dashboards/none"
    end
  end
end
