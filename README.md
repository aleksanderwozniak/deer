<h1 align="center">Deer</h1>

<div align="center">
  <img src="https://github.com/aleksanderwozniak/deer/blob/master/assets/images/4.0x/deer_logo.png" width=240> 
</div>

<h4 align="center">
  Minimalist Todo Planner app built around the idea of efficiency and clean aesthetic.
</h4>

## Showcase

<div style="text-align: center"><table><tr>
  <td style="text-align: center">
    <img src="https://github.com/aleksanderwozniak/deer/blob/assets/indi_list.png" width="250" />
  </td>
  <td style="text-align: center">
    <img src="https://github.com/aleksanderwozniak/deer/blob/assets/gold_shp_edt.png" width="250" />
  </td>
  <td style="text-align: center">
    <img src="https://github.com/aleksanderwozniak/deer/blob/assets/mint_wrk_det.png" width="250" />
  </td>
</tr></table></div>

<div align="center">
  <a href='https://play.google.com/store/apps/details?id=me.wozappz.deer&pcampaignid=MKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_gb/badges/images/generic/en_badge_web_generic.png' width="300"></a>
</div>


## Development

Deer uses BLoC (Business Logic Component) pattern to manage app state. If you want to use Streams in your Flutter project, then I think this is the way to go. BLoC plays exceptionally well with Flutter's reactive nature, especially since Flutter has built-in `StreamBuilder` widget.

Each screen is splitted into 4 files:
- actions
- bloc 
- screen (UI itself)
- state

Instead of calling `setState()` in screen file, an action is pushed to bloc's input `Stream<Action>`.
Then, bloc resolves that action and updates the output `Stream<State>`. Every state update is listened to inside screen with `StreamBuilder`, which updates the UI when needed. This way we achieve clear separation of concerns.

Usually with BLoC, `Sink` is used for input Stream, and `BehaviorSubject` for output Stream.

Check those resources for more details on the pattern:
- https://youtu.be/PLHln7wHgPE
- https://youtu.be/RS36gBEp8OI

#### Using built_value
```
flutter packages pub run build_runner build --delete-conflicting-outputs
```
