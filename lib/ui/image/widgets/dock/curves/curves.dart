import 'package:flutter/material.dart';
import 'dart:math' as math;


class SmoothCurve extends Curve {
  const SmoothCurve();

  @override
  double transform(double t) {
    // Clamp input to ensure it's between 0 and 1
    t = t.clamp(0.0, 1.0);

    // Implement the cubic bezier curve (0.25, 0.46, 0.45, 0.94)
    // Using the cubic bezier formula: B(t) = (1-t)³P₀ + 3(1-t)²tP₁ + 3(1-t)t²P₂ + t³P₃
    // Where P₀ = (0,0), P₁ = (0.25, 0.46), P₂ = (0.45, 0.94), P₃ = (1,1)

    double oneMinusT = 1.0 - t;
    double oneMinusTSquared = oneMinusT * oneMinusT;
    double oneMinusTCubed = oneMinusTSquared * oneMinusT;
    double tSquared = t * t;
    double tCubed = tSquared * t;

    // Calculate Y coordinate using cubic bezier formula
    double result =
        3 * oneMinusTSquared * t * 0.46 + // First control point influence
            3 * oneMinusT * tSquared * 0.94 + // Second control point influence
            tCubed; // End point influence

    // Ensure the result is never negative and within bounds
    result = math.max(0.0, result);
    result = math.min(1.0, result);

    return result;
  }

  @override
  String toString() => 'SmoothCurve(0.25, 0.46, 0.45, 0.94)';
}

// Premium iOS-style curve with subtle bounce effect
class PremiumBounceCurve extends Curve {
  const PremiumBounceCurve();

  @override
  double transform(double t) {
    // Clamp input to ensure it's between 0 and 1
    t = t.clamp(0.0, 1.0);

    // First 85% follows a smooth ease-out curve
    if (t < 0.85) {
      // Smooth acceleration with gentle deceleration
      double normalizedT = t / 0.85;
      double result = 1.0 - math.pow(1.0 - normalizedT, 3.0);
      return result * 0.98; // Slightly under 1.0 to prepare for bounce
    } else {
      // Last 15% creates a very subtle bounce
      double bounceT = (t - 0.85) / 0.15;

      // Subtle overshoot and settle - inspired by iOS spring animations
      double overshoot = 0.02 *
          math.sin(bounceT * math.pi * 2.5) *
          math.pow(1.0 - bounceT, 2.0);

      return math.min(1.0, 0.98 + (0.02 * bounceT) + overshoot);
    }
  }

  @override
  String toString() => 'PremiumBounceCurve(iOS-style)';
}

// Alternative premium curve with even more subtle bounce
class SubtleSpringCurve extends Curve {
  const SubtleSpringCurve();

  @override
  double transform(double t) {
    // Clamp input to ensure it's between 0 and 1
    t = t.clamp(0.0, 1.0);

    // iOS-inspired spring curve with very subtle overshoot
    // Based on UIViewPropertyAnimator's spring timing
    double result;

    if (t < 0.9) {
      // Main animation phase - smooth acceleration and deceleration
      double normalizedT = t / 0.9;
      result = normalizedT * normalizedT * (3.0 - 2.0 * normalizedT);
      result = result * 1.015; // Slight overshoot preparation
    } else {
      // Final 10% - very subtle settle
      double settleT = (t - 0.9) / 0.1;
      double settle = 0.015 * (1.0 - settleT) * math.cos(settleT * math.pi * 4);
      result = 1.015 - (0.015 * settleT) + settle;
    }

    // Ensure non-negative and bounded result
    return math.max(0.0, math.min(1.0, result));
  }

  @override
  String toString() => 'SubtleSpringCurve(iOS-inspired)';
}

// Alternative implementation with more precise cubic bezier calculation
class SmoothCurvePrecise extends Curve {
  const SmoothCurvePrecise();

  // Control points for cubic bezier (0.25, 0.46, 0.45, 0.94)
  static const double _x1 = 0.25;
  static const double _y1 = 0.46;
  static const double _x2 = 0.45;
  static const double _y2 = 0.94;

  @override
  double transform(double t) {
    // Clamp input to ensure it's between 0 and 1
    t = t.clamp(0.0, 1.0);

    // For cubic bezier curves, we need to solve for t given x
    // Since we're working with normalized time, we can use the approximation
    double result = _cubicBezier(t, _x1, _y1, _x2, _y2);

    // Ensure non-negative result
    return math.max(0.0, math.min(1.0, result));
  }

  // Cubic bezier calculation
  double _cubicBezier(double t, double x1, double y1, double x2, double y2) {
    double oneMinusT = 1.0 - t;
    double oneMinusTSquared = oneMinusT * oneMinusT;
    double oneMinusTCubed = oneMinusTSquared * oneMinusT;
    double tSquared = t * t;
    double tCubed = tSquared * t;

    // Cubic bezier formula for Y coordinate
    return 3 * oneMinusTSquared * t * y1 +
        3 * oneMinusT * tSquared * y2 +
        tCubed;
  }

  @override
  String toString() => 'SmoothCurvePrecise(0.25, 0.46, 0.45, 0.94)';
}
