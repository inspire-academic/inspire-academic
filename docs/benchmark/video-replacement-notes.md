# Video Placeholder — Notes

The benchmark lesson has no real video content yet. Rather than
embedding a broken player or a stock placeholder video, the "Video
Lesson" section uses a simple state object:

```js
const VIDEO_STATE = {
  status: 'coming_soon',   // 'coming_soon' | 'available'
  posterAlt: 'Distance and Displacement — video lesson',
  url: null
};
```

When `status === 'coming_soon'`, the section renders an Inspire-
branded card (gold accent, poster-style background, no fake play
button that does nothing) with the text "Video lesson coming soon" and
a short line pointing the student back to the written lesson content
below. No video upload dashboard, no third-party embed, no dead
`<video>` tag pointing at a non-existent file.

When real video exists, swap `status` to `'available'` and set `url`
to either a direct file path (`/assets/video/...`) or a hosted
embed URL — the render function should branch on `status`, not on
whether `url` is truthy, so a partially-filled-in state doesn't
silently render a broken player during content production.
