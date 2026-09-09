# Wasalny Repository Rules

## Architecture

- Use MVVM for the Buyer, Admin workflow, Packing, and Aliaa scenarios. Do not introduce Clean Architecture layers for these scenarios.
- Keep role features under `lib/src/features/users_type/<role>/` with `models`, `view_models`, and `views` directories.
- Put reusable or extracted view components under `views/widgets`.
- Keep one reusable widget per file. A `StatefulWidget` and its associated `State` class may remain together because they form one Flutter component.
- Views render state and forward user actions. ViewModels own mutable UI state and actions. Models contain data only.

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
