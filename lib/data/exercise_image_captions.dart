// lib/data/exercise_image_captions.dart
//
// Short captions shown under each exercise picture, explaining what the
// lighter (starting) and darker (finishing) figure in the image show.

const Map<String, String> exerciseImageCaptions = {
  'push_up': 'Lighter figure: top of the push-up, arms straight. Darker figure: the bottom, chest lowered toward the floor.',
  'wide_push_up': 'Same up-and-down motion as a push-up. Your hands would be set wider than your shoulders, wider than pictured.',
  'diamond_push_up': 'Same up-and-down motion as a push-up. Your hands would be close together under your chest, not spread as pictured.',
  'close_grip_push_up': 'Same up-and-down motion as a push-up. Your hands would be set under your shoulders, closer together than pictured.',
  'pike_push_up': 'Lighter figure: hips lifted high, arms straight, body in an upside-down V. Darker figure: elbows bent, head lowering toward the floor between the hands.',
  'shoulder_tap_plank': 'Lighter figure: a normal plank on both hands. Darker figure: one hand lifted to tap near the opposite shoulder while the hips stay still.',
  'prone_iyt_raise': 'Lighter figure: arms stretched forward along the floor, the "I" position. Darker figure: arms lifted and pulled back toward the "Y" and "T" positions, squeezing the shoulder blades.',
  'superman_pull': 'Lighter figure: arms reaching forward, chest and legs lifted off the floor. Darker figure: elbows pulled back toward the ribs, like a lat pulldown done lying down.',
  'reverse_snow_angel': 'Lighter figure: arms swept back by your sides. Darker figure: arms swept up and out into a wide arc overhead, staying off the floor.',
  'superman_hold': 'Hold this raised position: arms, chest, and legs lifted a few inches off the floor.',
  'self_resisted_curl': 'Lighter figure: arm hanging down. Darker figure: the arm curled up toward the shoulder while the other hand presses down for resistance.',
  'plank': 'Hold this straight-body position, resting on your forearms and toes.',
  'crunch': 'Lighter figure: lying flat, shoulders on the floor. Darker figure: shoulders curled up off the floor.',
  'mountain_climber': 'The legs alternate: one leg extends back while the other knee drives forward, like running in place while holding a plank.',
  'bicycle_crunch': 'Lighter figure: one leg extended straight. Darker figure: that knee pulled in while the opposite elbow twists toward it.',
  'lying_leg_raise': 'Lighter figure: legs resting down near the floor. Darker figure: legs raised straight up toward the ceiling.',
  'side_plank': 'Front-on view. Lighter figure: hips sagging toward the floor. Darker figure: hips lifted so your body forms one straight line.',
  'hollow_hold': 'Lighter figure: lying flat. Darker figure: shoulders and legs lifted a few inches off the floor into the hollow shape.',
  'bird_dog': 'Lighter figure: hand and knee both resting on the floor. Darker figure: the arm reaches forward and the opposite leg extends straight back.',
  'glute_bridge': 'Lighter figure: hips resting on the floor, knees bent. Darker figure: hips lifted so your body forms a straight line from shoulders to knees.',
  'single_leg_glute_bridge': 'One leg stays lifted the whole time. Lighter figure: hips resting down. Darker figure: hips lifted into the bridge.',
  'bodyweight_squat': 'Lighter figure: standing tall. Darker figure: hips pushed back and knees bent as you lower down.',
  'reverse_lunge': 'Lighter figure: standing tall. Darker figure: one leg stepped back, both knees bent to about 90 degrees.',
  'split_squat': 'Lighter figure: staggered stance, back knee straighter. Darker figure: the back knee lowered toward the floor.',
  'wall_sit': 'Hold this position with your back flat against the wall and your knees bent about 90 degrees.',
  'single_leg_rdl': 'Lighter figure: standing tall on one leg. Darker figure: hinged forward at the hips while the other leg reaches straight back.',
  'bridge_walkout': 'Lighter figure: bridge position with feet close to the hips. Darker figure: feet walked farther out, hips still lifted.',
  'calf_raise': 'Lighter figure: standing flat. Darker figure: risen onto the balls of the feet, heels lifted high.',
  'single_leg_calf_raise': 'One leg stays lifted behind you the whole time. Lighter figure: standing flat on the other foot. Darker figure: risen onto the ball of that foot.',
  'tibialis_wall_raise': 'Standing with your back against the wall. Lighter figure: foot flat on the floor. Darker figure: toes pulled up toward the shin, heel staying down.',
  'burpee': "Lighter figure: standing tall, the starting position. Darker figure: hands on the floor in a plank, after squatting down and kicking the feet back. The middle squat step isn't pictured.",
};

/// The caption for this exercise's image, or null if it has none.
String? imageCaptionFor(String exerciseId) => exerciseImageCaptions[exerciseId];