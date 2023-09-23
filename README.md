
Introducing Flutter Social Reaction, a versatile Flutter package for seamlessly integrating social reactions into your app. Customize emojis and assets as needed, or use the included sample icons for quick implementation. Enhance user engagement and feedback effortlessly with this flexible widget.
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
You can pass your assets and text through these values in a tabular format for your Flutter readme file:

| Value         | Description                        |
|---------------|------------------------------------|
| `likeGif`     | Your custom like GIF asset         |
| `likePng`     | Your custom like PNG asset         |
| `likeFillPng` | Your custom initial like PNG asset |
| `loveGif`     | Your custom love GIF asset         |
| `lovePng`     | Your custom love PNG asset         |
| `hahaGif`     | Your custom haha GIF asset         |
| `hahaPng`     | Your custom haha PNG asset         |
| `wowGif`      | Your custom wow GIF asset          |
| `wowPng`      | Your custom wow PNG asset          |
| `sadGif`      | Your custom sad GIF asset          |
| `sadPng`      | Your custom sad PNG asset          |
| `angryGif`    | Your custom angry GIF asset        |
| `angryPng`    | Your custom angry PNG asset        |
| `likeText`    | Your custom like text asset        |
| `loveText`    | Your custom love text asset        |
| `hahaText`    | Your custom haha text asset        |
| `wowText`     | Your custom wow text asset         |
| `sadText`     | Your custom sad text asset         |
| `angryText`   | Your custom angry text asset       |

Use these values to customize your Flutter application with the desired assets and text for social reactions.

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