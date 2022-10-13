import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var serverList = ['亚服', '欧服', '美服', '毛服'];
  bool translate = true;
  bool github = true;
  String dropdownvalue = '亚服';
  @override
  Widget build(BuildContext context) {
    dropdownvalue = Provider.of<Setting>(context).apiServerName;
    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child:
                  Text('API 设置', style: Theme.of(context).textTheme.labelLarge),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '游戏服务器: ',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  DropdownButton(
                    value: dropdownvalue,
                    style: Theme.of(context).textTheme.titleLarge,
                    items: serverList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: ((value) {
                      switch (value) {
                        case '亚服':
                          {
                            Provider.of<Setting>(context, listen: false)
                                .setApiServer('asia');
                          }
                          break;
                        case '欧服':
                          {
                            Provider.of<Setting>(context, listen: false)
                                .setApiServer('eu');
                          }
                          break;
                        case '美服':
                          {
                            Provider.of<Setting>(context, listen: false)
                                .setApiServer('com');
                          }
                          break;
                        case '毛服':
                          {
                            Provider.of<Setting>(context, listen: false)
                                .setApiServer('ru');
                          }
                          break;
                        default:
                          {
                            Provider.of<Setting>(context, listen: false)
                                .setApiServer('asia');
                          }
                      }
                      setState(() {
                        dropdownvalue = value ?? '亚服';
                      });
                    }),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '反和谐(没做关了也没用)',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Switch(
                      value: translate,
                      onChanged: ((value) {
                        Provider.of<Setting>(context, listen: false)
                            .setTranslate(value);
                        setState(() {
                          translate = value;
                        });
                      }))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '从 GitHub 获取信息(关了也没用)',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Switch(
                      value: github,
                      onChanged: ((value) {
                        Provider.of<Setting>(context, listen: false)
                            .setGithub(value);
                        setState(() {
                          github = value;
                        });
                      }))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
