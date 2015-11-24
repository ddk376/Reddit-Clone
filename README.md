# Reddit-Clone #
`cd` into directory
`rails s`
go to `localhost`

# Features #
Optimzation of N+1 queries
Reduced querying of children comments from O(n**2) to O(n)
Implements polymorphic votable on posts and comments with unsigned integer `+1` and `-1`
member route to upvote posts and comments
