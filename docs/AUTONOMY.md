# Autonomy Mode

Local Focus OS includes a controlled local autonomy mode.

It runs only local workflows through systemd user timers.

## Commands

    lf-autonomy on
    lf-autonomy off
    lf-autonomy status
    lf-autonomy run healthcheck
    lf-autonomy run morning
    lf-autonomy run evening
    lf-autonomy logs
    lf-autonomy reschedule 08:05:00 19:30:00 15

## Default Schedule

- Morning workflow: 08:05
- Evening review: 19:30
- Healthcheck: every hour at minute 15

## Safety Boundaries

Autonomy Mode does not:

- send emails automatically
- push to GitHub automatically
- delete user data automatically
- claim replies, confirmations or deadlines
- submit documents automatically

## Principle

The system can schedule and execute local review workflows.

External actions require human review.
