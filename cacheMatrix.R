## Analog to the mean example the set and get matrix function are defined inside
## the makeCacheMatrix function.
## Also the setinverse (based on solve!) and the getinverse are defined.

makeCacheMatrix <- function(x = matrix()) { 
   inv <- NULL
   set <- function(y) {
      x <<- y
      inv <<- NULL
   }
   get <- function() x
   setinverse <- function(solve) inv <<- solve
   getinverse <- function() inv
   list(set = set, get = get,
        setinverse = setinverse,
        getinverse = getinverse)   
} 

 
## In this function the getinverse and setinverse function is called

cacheSolve <- function(x, ...) { 
   ## Return a matrix that is the inverse of 'x' 
   
   inv <- x$getinverse()
   if(!is.null(inv)) {
      message("getting cached data")
      return(inv)
   }
   data <- x$get()
   inv <- solve(data, ...)
   x$setinverse(inv)
   inv
} 
