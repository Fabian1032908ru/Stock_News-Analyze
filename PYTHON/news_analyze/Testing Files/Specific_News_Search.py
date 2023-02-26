"""
Getting News from Wirecard to train machine
"""
import datetime

from GoogleNews import GoogleNews


def get_News(keyword: str, start_date: str, end_date: str):
    """
    Getting news in individual start to end date room
    :param keyword: What you want to search
    :param start_date: format -> "%m/%d/%Y"
    :param end_date: format -> "%m/%d/%Y"
    :return: Top results form googlenews
    """
    googlenews = GoogleNews(start=start_date, end=end_date)
    googlenews.get_news(keyword)
    google_result1 = googlenews.results()
    return google_result1


def loop_days(start_date: datetime.date, end_date: datetime.date, company: str):
    """
    Loop over the days we want to get the data
    :param start_date:
    :param end_date:
    :param company:
    :return: List of News of all days
    """
    result = []
    delta = datetime.timedelta(days=1)

    while start_date <= end_date:
        start_date_formatted = start_date.strftime("%m/%d/%Y")
        end_date_formatted = end_date.strftime("%m/%d/%Y")
        result.append(get_News(company, start_date_formatted, end_date_formatted))
        start_date += delta
    return result


if __name__ == '__main__':

    start = datetime.date(2020, 12, 1)  # Year Month Day
    end = datetime.date(2021, 1, 31)  # Year Month Day

    res = loop_days(start, end, "Wirecard")

    for re in res:
        for r in re:
            print(r["title"])
