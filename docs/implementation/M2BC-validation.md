# M2-B and M2-C Validation

Branch: `m0-apple-scaffold`

## M2-B status

Manual validation passed on July 2, 2026.

Validated controls in `FlybyNighterApp`:

- WASD movement
- Arrow-key movement
- Space firing
- Return and keypad Enter start/restart
- Click start/restart

The app now uses the shared `MacKeyboardGameView` adapter through a native AppKit shell.

## M2-C implementation

- Pause the SpriteKit view when the application becomes inactive.
- Pause when the game window loses key-window status.
- Clear held movement and firing before pause.
- Clear stale input again before resume.
- Resume when the application or game window becomes active.
- Restore keyboard focus after resume.
- Terminate after the final window closes.

## M2-C local validation

Run the test suite, build the app product, and launch it.

During a run, hold a movement key or Space and switch to another application. Gameplay should pause. Return to Flyby Nighter and confirm movement and firing are not stuck. Controls should work immediately after resume. Repeat by minimizing and restoring the game window.

## Deferred M2 work

- iPhone and iPad app shell
- Touch control validation
- App icon and distribution packaging
