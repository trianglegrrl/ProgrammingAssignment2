# cacheMatrix

## Introduction

This is a solution to Programming Assignment 2 for the Coursera Intruction to
R Programming.

The assignment explains why this is valuable:

> Matrix inversion is usually a costly computation and there may be some
> benefit to caching the inverse of a matrix rather than computing it
> repeatedly (there are also alternatives to matrix inversion that we will
> not discuss here). Your assignment is to write a pair of functions that
> cache the inverse of a matrix.

This solution uses the (delightful) lexical scoping of R to set up a cached interface to a matrix. The first time you request the inverse of a matrix, its result is calculated and stored in a cache. Any subsequent time the inverse of that matrix is requested, it pulls the result from the cache.

## Use (or just read the unit tests)

Execute the following code at your R command line:

```
    source('cachematrix.R')
```

Define or load a matrix, e.g.:

```
    sourceMatrix = matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2, byrow = TRUE)
```

Create a cache-able matrix and grab it. The first time you run it, it will calculate the inverse matrix. Every subsequent time, it will pull that calculated inverse from a cache rather than re-running it.
```
    # Define a cacheable matrix from the given matrix
    computedMatrix = makeCacheMatrix(sourceMatrix)

    # Get the matrix; this time it will not be pulled from the cache
    result = cacheSolve(computedMatrix)

    # Get the matrix again; this time it WILL be pulled from the cache so it doesn't have to run again
    anotherResult = cacheSolve(computedMatrix)
```
## Unit tests

I'm really loving the unit testing for assignments, so I thought it would be fun to write a super basic unit test (from scratch) for this app. The proper thing to do would be to use (RUnit)[http://cran.r-project.org/web/packages/RUnit/index.html], the R unit testing framework.

Instead, you can use my dumb test:

```
     source('cachematrix_tests.R')
     suppressWarnings(test.runTests())
```

If the code works, you should see output that looks like this:

```
    Running tests...
    cacheSolve()
        - Returned expected value.
        - Pulled result from cache
    Tests passed!
```

Happy caching!

-- Alaina Hardie, @trianglegrrl
