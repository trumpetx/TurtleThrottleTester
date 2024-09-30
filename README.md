# Turtle Throttle Tester
This addon performs a basic throttling test on Turlte Wow used to determine what the throttling rules actually are.  Modifying the code is required in order to perform separate tests.

`/join TTT` in order to perform the test as-is.  If you're trying to test `/w`, modify the code appropriately.  Make sure all other addons are off (to avoid other addons sending their own messages to affect the test).

```
TurtleThrottleTester.Delay = .1
```

Modify this value to the delay between "Chats".  A value of .1 will send 10 chats per 1 second.

# Tests

On 2024-09-30, the following tests were performed:

|Delay|Mutes|Messages|Time (seconds)|
|---|---|---|---|
|5.5|0|12|60|
|4.5|0|13|60|
|3.5|0|18|60|
|3|1|17|60|
|2.5|1|20|60|
|2|2|22|60|
|1|3|33|60|
|.1|6|66|60|
|1|0|10|10|
|.9|0|11|10|
|.85|1|11|10|
|.1|1|11|10|

# Conclusion

|Limit|Time (seconds)|
|---|---|
|11|1|
|11|10|
|11|30|
|11|?45?|

If you cross more than 11 messages over any of those thresholds, then you're muted and your limit is reset.

As you can see, there's basically no reason why any addon should "keep under" the throttle limit because the throttle limit is insainely high.  The best you can do is just spam as much as you can/want, eat the mute, then continue spamming which I am sure is not the intention of the Turtle Dev Team.

