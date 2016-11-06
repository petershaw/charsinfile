# charsinfile
Read a file by char in Swift

This project is a prototye to find out the fastest solution to read a file char by char.

Relates StackOverflow Thread: http://stackoverflow.com/questions/40450190/what-is-the-fastest-char-by-char-reader-in-swift
And the "b" example from: http://stackoverflow.com/a/34595661/1187415 (Thanks to @RobNapier)

# Testing the different Solutions

1. Generate a testfile: 

```
openssl rand -out sample.txt -base64 $(( 2**30 * 3/4 ))
```

2. test the file with both types: 

```
time ./charsinfile sample.txt a -> result-a.txt
time ./charsinfile sample.txt b -> result-b.txt
```

3. test the results:

```
diff result-a.txt sample.txt
diff result-a.txt result-b.txt
```

