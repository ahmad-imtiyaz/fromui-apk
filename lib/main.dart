import 'package:flutter/material.dart' as material;
import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int _counter = 0;
  bool _checked = false;
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final platform = FPlatformVariant.android;
    final brightnessTheme = platform.desktop
        ? FTheme.neutral.light.desktop
        : FTheme.neutral.light.touch;

    return MaterialApp(
      locale: const Locale('en', 'US'),
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      theme: brightnessTheme.toApproximateMaterialTheme(),
      builder: (context, child) => FTheme(
        data: brightnessTheme,
        platform: platform,
        child: FToaster(
          child: FTooltipGroup(child: child ?? const SizedBox()),
        ),
      ),
      home: Builder(
        builder: (context) {
          return FScaffold(
            header: FHeader(
              title: const Text('ForUI Widget Demo'),
              suffixes: [
                FHeaderAction(
                  icon: const Icon(material.Icons.auto_awesome),
                  onPress: () {},
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Section: Text Field ---
                    const Text('Text Field'),
                    const SizedBox(height: 8),
                    FTextField(
                      hint: 'Ketik sesuatu...',
                    ),
                    const SizedBox(height: 16),

                    // --- Section: Checkbox ---
                    FCheckbox(
                      value: _checked,
                      onChange: (v) => setState(() => _checked = v),
                      label: Text('Checkbox: ${_checked ? "Checked" : "Unchecked"}'),
                    ),
                    const SizedBox(height: 16),

                    // --- Section: Buttons ---
                    FButton(
                      onPress: () => setState(() => _counter++),
                      child: Text('Increment (${_counter.toString()})'),
                    ),
                    const SizedBox(height: 8),
                    FButton(
                      onPress: _showDialog,
                      variant: FButtonVariant.secondary,
                      child: const Text('Open Dialog'),
                    ),
                    const SizedBox(height: 16),

                    // --- Section: Card ---
                    FCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Card Title', style: material.TextStyle(fontWeight: material.FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('This is a ForUI Card widget. Counter: $_counter'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- Section: Alert ---
                    FAlert(
                      variant: FAlertVariant.primary,
                      title: const Text('Info'),
                      subtitle: const Text('This is a ForUI Alert widget.'),
                    ),
                    const SizedBox(height: 16),

                    // --- Section: Tabs ---
                    FTabs(
                      control: FTabControl.lifted(
                        index: _selectedTab,
                        onChange: (index) => setState(() => _selectedTab = index),
                      ),
                      children: const [
                        FTabEntry(label: Text('Tab 1'), child: SizedBox.shrink()),
                        FTabEntry(label: Text('Tab 2'), child: SizedBox.shrink()),
                        FTabEntry(label: Text('Tab 3'), child: SizedBox.shrink()),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Tab Content
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Content for Tab ${_selectedTab + 1}',
                        style: material.Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDialog() {
    showFDialog(
      context: context,
      builder: (context, style, animation) {
        return FDialog(
          builder: (context, dialogStyle) {
            return material.SafeArea(
              child: material.Column(
                mainAxisSize: material.MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('ForUI Dialog', style: material.TextStyle(fontWeight: material.FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Ini adalah contoh dialog dari ForUI widget library.'),
                  ),
                  const SizedBox(height: 16),
                  FButton(
                    onPress: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
