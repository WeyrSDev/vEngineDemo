#pragma once
#include "vDrawableComponent.h"

using namespace vEngine;

namespace vEngine {
	class Effect;
	class Keyboard;
	class Light;
	class RenderStateHelper;
}

namespace DirectX {
	class SpriteBatch;
	class SpriteFont;
}

namespace Rendering {
	class AmbientLightingMaterial;
	class AmbientLightingDemo : public DrawableComponent {
		RTTI_DECLARATIONS(AmbientLightingDemo, DrawableComponent)
	public:
		AmbientLightingDemo(Engine& game, Camera& camera);
		~AmbientLightingDemo();
	private:
		AmbientLightingDemo();
		AmbientLightingDemo(const AmbientLightingDemo& rhs);
		AmbientLightingDemo& operator=(const AmbientLightingDemo& rhs);
	public:
		virtual void Initialize() override;
		virtual void Update(const Time& gameTime) override;
		virtual void Draw(const Time& gameTime) override;
	private:
		void UpdateAmbientLight(const Time& gameTime);
	private:
		static const float AmbientModulationRate;
	private:
		Effect* mEffect;
		AmbientLightingMaterial* mMaterial;
		ID3D11ShaderResourceView* mTextureShaderResourceView;
		ID3D11Buffer* mVertexBuffer;
		ID3D11Buffer* mIndexBuffer;
		UINT mIndexCount;
		Keyboard* mKeyboard;
		Light* mAmbientLight;
		XMFLOAT4X4 mWorldMatrix;
		RenderStateHelper* mRenderStateHelper;
		SpriteBatch* mSpriteBatch;
		SpriteFont* mSpriteFont;
		XMFLOAT2 mTextPosition;
	};
}