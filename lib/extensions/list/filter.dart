// extension type in dart allows you to add new functionality to an 
// already existing class in these case stream of list of type T
// without modifying it. 
// name of these extension is FILTER and it is generic meaning it can be used by all data
// types that is why we have <T> after the name of the extension.
// on Stream<List<T>> means that this extension is only applicable 
// to Stream of List of type T which is lso generic.
extension Filter<T> on Stream<List<T>> {
  // Stream of list of type T is the return type of this function
  // whose name is filter and it takes a function of return type bool which in this case 
  // is generic and takes a parameter of type T whose parameter name is where.
  // now this function will return an iterable map which will take an 
  // argument of items whose type is T and return that items after applying
  // the where function on it and converting it to a list again with the toList method which
  // is the return type of this function.
  Stream<List<T>> filter(bool Function(T) where)=>
      map((items) => items.where(where).toList());
}
