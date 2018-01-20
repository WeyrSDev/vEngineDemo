#pragma once

#include "vInclude.h"
#include "vEngine.h"

using namespace vEngine;

namespace DirectX
{
    class SpriteBatch;
    class SpriteFont;
}

namespace vEngine
{
	class FpsCounter;
	class Keyboard;
	class Mouse;
	class FPSCamera;
	class PerspectiveCamera;
	class OrthographicCamera;
	class Grid;
	class RenderStateHelper;
	class Skybox;
	
}

namespace Rendering {
	class CubeDemo;
	class TriangleDemo;
	class ModelDemo;
	class TexturedModel;
    class RenderingGame : public Engine {
    public:
		RenderingGame(HINSTANCE instance, const std::wstring& windowClass, const std::wstring& windowTitle, int showCommand);
		~RenderingGame();
	public:
		virtual void Initialize() override;
		virtual void Update(const Time& gameTime) override;
		virtual void Draw(const Time& gameTime) override;
	protected:
		virtual void Shutdown() override;
	private:
		static const XMVECTORF32 BackgroundColor;
		LPDIRECTINPUT8 mDirectInput;
		Keyboard* mKeyboard;
		Mouse* mMouse;
		FPSCamera* mCamera;
		//PerspectiveCamera* mCamera;
		//OrthographicCamera* mCamera;
		FpsCounter* mFpsComponent;
		Grid* mGrid;
		RenderStateHelper* mRenderStateHelper;
		//CubeDemo* mDemo;
		//TriangleDemo* mDemo;
		Skybox* mSkybox;

		ModelDemo* mModelDemo;
		TexturedModel* mTexturedModel;

    };
}