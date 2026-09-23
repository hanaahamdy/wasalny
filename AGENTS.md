# Wasalny Repository Rules

## Architecture

- Use MVVM for the Buyer, Admin workflow, Packing, and Aliaa scenarios. Do not introduce Clean Architecture layers for these scenarios.
- Keep role features under `lib/src/features/users_type/<role>/` with `models`, `view_models`, and `views` directories.
- Put reusable or extracted view components under `views/widgets`.
- Keep one reusable widget per file. A `StatefulWidget` and its associated `State` class may remain together because they form one Flutter component.
- Views render state and forward user actions. ViewModels own mutable UI state and actions. Models contain data only.

## API Integration

- Follow MVVM when integrating every new endpoint. Keep request execution and response mapping outside views and Cubits.
- Put typed request/response data classes in the feature's `models` directory. Models contain data and JSON mapping only.
- Put endpoint calls in a dedicated feature service file, such as `services/auth_service.dart`. The service receives `NetworkService`, builds the `NetworkRequest`, calls the endpoint, validates the response, and returns a typed model.
- Add endpoint paths to `lib/src/core/network/api_endpoints.dart`; do not hard-code endpoint strings inside views or Cubits.
- Treat Cubits as ViewModels. They own form keys, text controllers, mutable UI state, user actions, persistence coordination, palette changes, and navigation decisions.
- Do not use presentation mixins for endpoint actions. Implement the action directly in its Cubit/ViewModel and dispose controllers in `close()`.
- Views must only render Cubit state and forward user actions. Do not call `NetworkService`, parse API responses, persist authentication, or decide role routes in a view.
- Use `BaseStatus` from `lib/src/core/extensions/base_state.dart` for request state. Emit `BaseStatus.loading` before the request, `BaseStatus.success` after success, and `BaseStatus.error` after failure. Read loading through `state.status.isLoading`.
- While a request is loading, show a progress indicator in the action button and disable the button. Keep a loading guard in the Cubit when needed to prevent duplicate requests.
- Use the project `Result` flow through `handleCallbackWithFailure()` and handle outcomes with `result.when(...)`. Do not add local `try`/`catch` blocks to Cubits for normal API handling.
- Show API failures using the existing localized message/snackbar utilities. Do not add hard-coded error messages.
- For authenticated responses, persist the typed user and access token through `UserCubit`; do not write authentication cache values directly from a view.
- Keep role-based navigation functions in the responsible Cubit/ViewModel. Use `Go.offAll` after authentication or startup so users cannot return to authentication screens through Back.
- When a response includes `system_type`, apply it through `AppColors.selectedScenario` before navigating to the role cycle.

## Startup and Notifications

- Initialize `NotificationNavigator` and `NotificationService` from the splash startup flow, not from a home screen.
- Splash must restore the base URL and cached authentication before selecting the initial route.
- When no initial notification exists, Splash routes to Login for signed-out users or to the cached user's role cycle for signed-in users.
- When the app opens from a terminated-state notification, establish the authenticated user's base role route before applying `NotificationRoutes.navigateByType`.
- Guard the splash flow against duplicate initial navigation.

## Scenario State

- Buyer, Admin approval, Packing, and Aliaa are isolated UI scenarios until backend integration is requested.
- Create fresh ViewModel state whenever a scenario screen is entered; do not use a shared singleton to connect scenarios.
- Seed each scenario with enough mock records to show the full UI immediately.
- An action in one scenario must not add, remove, approve, or otherwise change records in another scenario.
- Sending an order from Packing removes it from the current Packing UI only.
- Completing an order in Aliaa removes it from the current Aliaa UI only.
- Live is currently an approval/status UI demonstration only. Do not open a camera, start streaming, or create/inject a Live URL unless explicitly requested.

## Localization

- Never create feature localization wrappers such as `WorkflowL10n`.
- Access localized strings through typed `LocaleKeys` members, for example `LocaleKeys.register`.
- Add every new user-facing string to both `assets/translations/en.json` and `assets/translations/ar.json`.
- Add the corresponding getter or parameterized method to `lib/src/config/language/locale_keys.g.dart`.
- Do not leave hard-coded user-facing text in scenario views, dialogs, buttons, validation messages, snack bars, or empty states.

## Workflow UI

- Workflow headers must visually match the Admin and Delivery home header: render `AppColors.scenarioGradient`, use a transparent status bar with light icons, and avoid Material surface tint overlays.
- The Buyer landing screen contains separate Category Order and Live cards.
- The Buyer category form follows the existing Admin create-order design and must not include a phone field.
- Keep the Packing “Send to Aliaa” label on one line.
- Packing and Aliaa must support multiple visible records.
- The role-selection radio buttons select only the color palette; they never filter or change the available roles. All roles remain visible with either selection.
- Scenario 1 is the Philippine brand palette and is the default. Scenario 2 preserves the green/teal palette.
- All screens and roles must read active colors through `AppColors.scenario*`; do not hard-code a scenario palette in feature widgets.

## Verification

- After changing these features, run `flutter analyze` on the affected feature directories.
- Preserve unrelated user changes and avoid editing unrelated warnings unless explicitly requested.
