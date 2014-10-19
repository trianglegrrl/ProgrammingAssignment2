##
## This is Programming Exercise 2 for the Coursera "Introduction to R Programming" course.
##
## Taken together, the functions defined below provide a cached interface to a potentially
## computationally intensive task: computing the inverse of a matrix. In this code, we
## define two functions: one to do the matrix inversion and store the result in a cache,
## and another that provides an interface to the matrix inversion, checking for a
## cached result and returning it if it is available, or calling a new instance of the
## inversion caching function if it is not.
##
##
## Note: As written, this solution is unable to handle a dataset that changes during its
## run.
##
## Alaina Hardie, @trianglegrrl, github.com/trianglegrrl
## 2014-10-19


## makeCacheMatrix()
##
## Set up a cached version of the inversion of the matrix. This function
## defines a set of cache management tools, allowing you to get and set
## the cached inverted matrix.
##

makeCacheMatrix <- function(sourceMatrix = matrix()) {
    # Define a variable to hold the cached result of the inverse of sourceMatrix
    cache <- NULL

    # Store the cached value in the enclosing environment and empty that environment's
    # cache
    set <- function(cachedValue) {
            sourceMatrix <<- cachedValue
            cache <<- NULL
    }

    # Return the passed matrix.
    get <- function() sourceMatrix

    # Stick the inverse result in the enclosing environment's cache
    setInverse <- function(inverse) cache <<- inverse

    # Return the cached inverse, which null if unset
    getInverse <- function() cache

    # return a list of the results.
    list(set = set, get = get,
         setInverse = setInverse,
         getInverse = getInverse)
}


## cacheSolve()
##
## Given a matrix, provide its cached inverse if it exists; otherwise,
## caclulate the inverted matrix and store the result in the cache.

cacheSolve <- function(requestedMatrix, ...) {
    # Ask if this matrix has already been inverted; if so, get it.
    inverseMatrix <- requestedMatrix$getInverse()

    # If the matrix has already been inverted, tell the user we're using the cached
    # version, and then return the cached version, exiting the cacheSolve function.
    if(!is.null(inverseMatrix)) {
        warning("Found a cached result; using that.")
        invisible(inverseMatrix)
    }

    # A cached version was not found, so compute the inverse of the matrix.
    # Pass along to solve() any required arguments that were passed in.
    sourceMatrix <- requestedMatrix$get()
    computedInverse <- solve(sourceMatrix, ...)

    # Store the computed inverse in the cache and implicitly return the result.
    requestedMatrix$setInverse(computedInverse)
}
