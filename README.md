
This is a fully dynamic package for incorporating social reactions into your flutter application as needed. Flutter Social Reaction is a fully customizable widget that allows you to pass your favorite emo and assets if necessary, while sample icons are already included in the package.

## Features

![social_reaction_ui](https://user-images.githubusercontent.com/55906788/220020033-ee2c55ac-1a0f-42c0-a90a-902ee5d49527.gif)

## Usage

# pubspec.yaml
```

dependencies:

flutter:

sdk: flutter

flutter_social_reaction:  any

```

## Demo

```
class SocialReactionMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Social Reactions ',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SocialReactionCollection(),
    );
  }
} 
```

You can call SocialReactionCollection() anywhere in your application and pass the parameters listed below to make full use of this package. The package handles all controllers, animations, and positions.

## Parameters

You can pass your assets and text through these values.

String? likeGif     -> pass string for your own like gif assets.

String? likePng     -> pass string for your own like png assets.

String? likeFillPng -> pass string for your own initial like png assets.

String? loveGif     -> pass string for your own love gif assets.

String? lovePng     -> pass string for your own love png assets.

String? hahaGif     -> pass string for your own haha gif assets.

String? hahaPng     -> pass string for your own haha png assets.

String? wowGif      -> pass string for your own wow gif assets.

String? wowPng      -> pass string for your own wow png assets.

String? sadGif      -> pass string for your own sad gif assets.

String? sadPng      -> pass string for your own sad png assets.

String? angryGif    -> pass string for your own angry gif assets.

String? angryPng    -> pass string for your own angry png assets.

String? likeText    -> pass string for your own like text assets.

String? loveText    -> pass string for your own love text assets.

String? hahaText    -> pass string for your own haha text assets.

String? wowText     -> pass string for your own wow text assets.

String? sadText     -> pass string for your own sad text assets.

String? angryText   -> pass string for your own angry text assets.

## LICENSE
Copyright (c) 2023 Ambika Dulal

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Softwre"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


## How to Contribute

1. Fork it
2. Create your feature branch (git checkout -b new-feature)
3. Commit your changes (git commit -m 'Add some feature')
4. Push to the branch (git push origin new-feature)
5. Create new Pull Request

## For help getting started with Flutter, view online documentation.

## For help on editing package code, view the documentation.