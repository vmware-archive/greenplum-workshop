## User Defined Aggregates

A user defined aggregate requires the following components:
* A new aggregate definition that specifies the input (base) type `[input_data_type]`
* A state transition function to calculate the running state aggregates from the records passed to it `[sfunc]`
* A new type that holds the running state of the aggregate's result (between the processing of each record) `[stype]`
* The function to be used for calculating the aggregate `[finalfunc]`
* Initial condition for the state variable type `[initcond]`
