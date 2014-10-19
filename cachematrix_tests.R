##
## Unit testing for cacheMatrix: Programming Exercise 2 for the Coursera
## "Introduction to R Programming" course.
##
## Hand-coded remedial unit testing helps me lurn R good and verifies code is working
## (Would probably use RUnit for actual testing: `install.packages('RUnit')`)
##
## To run test suite:
##
##         source('cachematrix_tests.R')
##         suppressWarnings(test.runTests())
##
## Expected results defined at https://class.coursera.org/rprog-008/forum/thread?thread_id=174
##
## Alaina Hardie, @trianglegrrl, github.com/trianglegrrl
## 2014-10-19

# Load the file to be tested
source('cachematrix.R')

# Set up test suite
test.runTests <- function () {
    message("Running tests...")

    cacheSolve = test.cacheSolve()

    if(cacheSolve)
    {
        message("Tests passed!")
    } else {
        stop("Tests FAILED! See output above for details.")
    }
}

## Unit test for cacheSolve() function

test.cacheSolve <- function () {
        # Define the source matrix
        sourceMatrix <- matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2, byrow = TRUE)

        # Define the expected result
        invertedMatrix <- matrix(c(-2, 1, 1.5, -0.5), nrow = 2, ncol = 2, byrow = TRUE)

        # Set up the cache and run the calculation
        computedMatrix <- makeCacheMatrix(sourceMatrix)
        result <- cacheSolve(computedMatrix)

        # Test #1, verifying the result is what is expected
        message("cacheSolve()")

        # Compare the actual and expected results, and report whether the test succeeded
        comparisonResult <- all.equal(invertedMatrix, result)
        if((typeof(comparisonResult) == 'logical') & comparisonResult == TRUE) {
                message("        - Returned expected value.")
        } else {
                message("        - DID NOT return expected value.")
                message(paste("            Expected: ", invertedMatrix))
                message(paste("            Got: ", result))
                return(FALSE)
        }

        # Test #2, confirming that a repeat hit is pulled from the cache
        result <- cacheSolve(computedMatrix)

        # Variable to describe whether we got the cache-hit warning() message
        gotCacheHit <- FALSE

        # If cacheSolve() hits the cache, it throws a warning(). Test for that condition.
        tryCatch({
            cacheSolve(computedMatrix)
        }, warning = function(w) {
            gotCacheHit <<- TRUE
        })

        # Compare the results and determine if test succeded
        if(gotCacheHit) {
            message("        - Pulled result from cache")
            TRUE
        } else {
            message("        - DID NOT pull result from cache")
            FALSE
        }
}
