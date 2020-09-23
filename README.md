# StackQuestions
Coding exercise using the stackexchange API.
The project uses the most basic URL to make the request to the stackexchange API; It contains the page size and the site that we want to request from. Additional parameters can be added, some of them are the order, sorting, max, tab, hottab etc.

The decision to use the most basic one was taken  because we can keep receiving questions when refreshing the app. If we were to sort the results by votes we would normally get the same ones all the time, on the other hand, if we sort them by creation date then we have locations in which none meet the criteria to be presented in the app (answered and more than one answer).
