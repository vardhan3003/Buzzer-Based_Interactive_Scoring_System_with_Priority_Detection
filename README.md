1. INTRODUCTION

This project involves the design and implementation of a Buzzer-Based Interactive Scoring System on an FPGA using Verilog. The system is engineered to handle real-time input detection and prioritization with nanosecond-level precision, ensuring fair and accurate scoring. It supports multiple teams competing for the fastest response and provides immediate feedback through LEDs as a buzzer. The following sections detail the operation and implementation of the scoring system.


2. STATES OF OPERATION

The system operates in three primary states:

2.1 Idle State:
In this default state, the system continuously monitors button presses from teams (A, B, and C). If a button is pressed, a counter starts to detect and differentiate input timings. If no valid press is detected, the counters reset to avoid false triggers.

2.2 Press Done State:
When a button press exceeds the pre-defined threshold (e.g., 1-second press duration), the system registers the response and triggers the corresponding LED to indicate the team’s win. This state includes a timed visual feedback mechanism (LED blinking) before transitioning back to the Idle State.

2.3 Scoring State:
In this state, the system enables the manual adjustment of scores for each team. Using inc and dec inputs, users can increment or decrement scores for teams A, B, or C. The scores are dynamically displayed on the 7-segment display, ensuring accurate and real-time updates.


3. CONSTRAINTS OF THE BOARD

3.1 Inputs (Push Buttons):

A, B, C: Button inputs for teams A, B, and C to register their responses.
score_on: Enables the scoring mode for manual score adjustment.
score_A, score_B, score_C: Selects the team whose score is to be adjusted in scoring mode.
inc: Increments the selected team's score.
dec: Decrements the selected team's score.
reset: Resets all counters and timers to their default state.

3.2 LEDs:

Indicates the winning team in the Press Done State:
LED[2]: Team A wins.
LED[1]: Team B wins.
LED[0]: Team C wins.

3.3 Seven-Segment Display:

Displays the scores for teams A, B, and C in real-time.
In Scoring Mode: Highlights the team being edited with blinking digits.


4. KEY FEATURES

High Precision: Detects button press timings down to nanoseconds, ensuring fair input registration.
Dynamic Scoring: Allows real-time score updates for multiple teams with instant display feedback.
Interactive Feedback: Uses LEDs and buzzers to provide clear indications of states and events.
Robust Design: Includes debounce logic to eliminate false triggers, ensuring reliable operation.
