// UIImage+Reflecting.swift
// Copyright (c) 2016 Nyx0uf
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import UIKit


public extension UIImage
{
	public func reflected(height: UInt, fromAlpha: CGFloat = 1.0, toAlpha: CGFloat = 1.0) -> UIImage?
	{
		guard let cgImage = self.cgImage else
		{
			return nil
		}

		if height == 0
		{
			return nil
		}

		UIGraphicsBeginImageContextWithOptions(CGSize(width: Int(self.size.width), height: Int(height)), false, 0.0)
		guard let mainViewContentContext = UIGraphicsGetCurrentContext() else
		{
			return nil
		}

		guard let gradientMaskImage = CGImage.makeGrayGradient(width: 1, height: Int(height), fromAlpha: fromAlpha, toAlpha: toAlpha) else
		{
			return nil
		}

		mainViewContentContext.clip(to: CGRect(x: 0, y: 0, width: Int(self.size.width), height: Int(height)), mask: gradientMaskImage)
		mainViewContentContext.draw(cgImage, in: CGRect(x: 0, y: 0, width: Int(self.size.width), height: Int(self.size.height)))

		let theImage = UIGraphicsGetImageFromCurrentImageContext()

		UIGraphicsEndImageContext()

		return theImage
	}
}
